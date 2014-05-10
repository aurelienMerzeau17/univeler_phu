using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Transactions;
using System.Web.Security;
using DotNetOpenAuth.AspNet;
using Microsoft.Web.WebPages.OAuth;
using WebMatrix.WebData;
using phu.Filters;
using phu.Models;

namespace phu.Controllers
{
    public class AdminController : Controller
    {
        private phu_bddEntities db = new phu_bddEntities();

        //
        // GET: /Admin/

        public ActionResult Index()
        {
            var evenement = db.evenement.Include(e => e.localisation);
            return View(evenement.ToList());
        }

        public ActionResult Login()
        {
            return View();
        }

        public ActionResult Create()
        {
            ViewBag.localisation_id = new SelectList(db.localisation, "localisation_id", "address");
            return View();
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult Create(evenement evenement, string contentDescription, string txtDatePrevue)
        {
            evenement.date_event = Convert.ToDateTime(txtDatePrevue);
            evenement.description = contentDescription;
            evenement.UserId = db.UserProfile.Where(i => i.UserName == WebSecurity.CurrentUserName).First().UserId;
            if (ModelState.IsValid)
            {
                event_user eu = new event_user();
                evenement.actual_people += 1;
                db.evenement.Add(evenement);
                db.SaveChanges();

                eu.event_id = db.evenement.Max(i => i.event_id);
                eu.UserId = db.UserProfile.Where(i => i.UserName == WebSecurity.CurrentUserName).First().UserId;
                db.event_user.Add(eu);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.localisation_id = new SelectList(db.localisation, "localisation_id", "address", evenement.localisation_id);
            return View(evenement);
        }

        public ActionResult Edit(int id = 0)
        {
            evenement evenement = db.evenement.Find(id);
            if (evenement == null)
            {
                return HttpNotFound();
            }
            ViewBag.localisation_id = new SelectList(db.localisation, "localisation_id", "address", evenement.localisation_id);
            return View(evenement);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult Edit(evenement evenement, string contentDescription, string txtDatePrevue)
        {
            if (ModelState.IsValid)
            {
                evenement vent = db.evenement.Find(evenement.event_id);
                vent.date_event = Convert.ToDateTime(txtDatePrevue);
                vent.name = evenement.name;
                vent.description = contentDescription;
                vent.max_people = evenement.max_people;
                vent.localisation.address = evenement.localisation.address;
                vent.localisation.cp = evenement.localisation.cp;
                vent.localisation.city = evenement.localisation.city;

                db.SaveChanges();
                return RedirectToAction("Index", "Home");
            }
            ViewBag.localisation_id = new SelectList(db.localisation, "localisation_id", "address", evenement.localisation_id);
            return View(evenement);
        }

        public ActionResult Validate(int id = 0)
        {
            if (ModelState.IsValid)
            {
                evenement vent = db.evenement.Find(id);
                vent.validate = vent.validate == 1 ? 0 : 1;
                db.Entry(vent).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View();
        }

        public ActionResult Delete(int id = 0)
        {
            evenement evenement = db.evenement.Find(id);
            if (evenement == null)
            {
                return HttpNotFound();
            }
            return View(evenement);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            evenement evenement = db.evenement.Find(id);
            foreach (event_user eu in db.event_user)
            {
                if(eu.event_id == id)
                {
                    db.event_user.Remove(eu);
                }
            }            
            db.evenement.Remove(evenement);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginModel model/*, string returnUrl*/)
        {
            if (ModelState.IsValid)
            {

                int isAdmin = (from i in db.UserProfile
                               where i.UserName == model.UserName
                               select i.user.FirstOrDefault().admin).FirstOrDefault();


                if (isAdmin == 1 && WebSecurity.Login(model.UserName, model.Password, persistCookie: model.RememberMe))
                {
                    return RedirectToLocal("Admin/Index");
                }
                else
                {
                    ModelState.AddModelError("", "Vous n'êtes pas Administrateur.");
                    return View(model);
                }
            }

            // Si nous sommes arrivés là, quelque chose a échoué, réafficher le formulaire
            ModelState.AddModelError("", "Le nom d'utilisateur ou mot de passe fourni est incorrect.");
            return View(model);
        }

        #region Applications auxiliaires
        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction("Index", "Admin");
            }
        }
        #endregion
    }
}