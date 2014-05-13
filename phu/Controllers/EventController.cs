using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using phu.Models;
using System.Data.Objects;
using System.Data.Entity.Infrastructure;
using System.Web.Security;
using WebMatrix.WebData;

namespace phu.Controllers
{
    public class EventController : Controller
    {
        private phu_bddEntities db = new phu_bddEntities();

        //
        // GET: /Default1/

        public ActionResult Index()
        {
            var evenement = db.evenement.Include(e => e.localisation);
            return View(evenement.ToList());
        }

        //
        // GET: /Default1/Details/5
        [HttpGet]
        public PartialViewResult Details(int id)
        {
            evenement evenement = db.evenement.Find(id);

            return PartialView(evenement);
        }

        
        public ActionResult Create()
        {
            ViewBag.localisation_id = new SelectList(db.localisation, "localisation_id", "address");
            return View();
        }

        //
        // POST: /Default1/Create

        [HttpPost, ValidateInput(false)]
        public ActionResult Create(evenement evenement, string contentDescription, string txtDatePrevue)
        {

            DateTime dateValue;
            if(DateTime.TryParse(txtDatePrevue, out dateValue))
            {
                evenement.date_event = dateValue;
            }
            else
            {
                evenement.date_event = DateTime.MinValue;
            }
            evenement.description = contentDescription;
            evenement.UserId = db.UserProfile.Where(i => i.UserName == WebSecurity.CurrentUserName).First().UserId;
            if (ModelState.IsValid)
            {
                //try
                //{
                    event_user eu = new event_user();
                    evenement.actual_people += 1;
                    db.evenement.Add(evenement);
                    db.SaveChanges();

                    eu.event_id = db.evenement.Max(i => i.event_id);
                    eu.UserId = db.UserProfile.Where(i => i.UserName == WebSecurity.CurrentUserName).First().UserId;
                    db.event_user.Add(eu);
                    db.SaveChanges();
                    return RedirectToAction("Index", "Home");
                //}
                //catch (Exception ex)
                //{
                //    throw new InvalidOperationException(ex.ToString());
                //}
            }

            ViewBag.localisation_id = new SelectList(db.localisation, "localisation_id", "address", evenement.localisation_id);
            return View(evenement);
        }

        //
        // GET: /Default1/Edit/5

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

        //
        // POST: /Default1/Edit/5

        [HttpPost, ValidateInput(false)]
        public ActionResult Edit(evenement evenement, string contentDescription, string txtDatePrevue)
        {
            DateTime dateValue;
            if (DateTime.TryParse(txtDatePrevue, out dateValue))
            {
                evenement.date_event = dateValue;
            }
            else
            {
                evenement.date_event = DateTime.MinValue;
            }
            if (ModelState.IsValid)
            {
                evenement vent = db.evenement.Find(evenement.event_id);
                vent.date_event = evenement.date_event;
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

        //
        // GET: /Default1/Delete/5

        public ActionResult Delete(int id = 0)
        {
            evenement evenement = db.evenement.Find(id);
            if (evenement == null)
            {
                return HttpNotFound();
            }
            return View(evenement);
        }

        //
        // POST: /Default1/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            evenement evenement = db.evenement.Find(id);
            foreach (event_user eu in db.event_user)
            {
                if (eu.event_id == id)
                {
                    db.event_user.Remove(eu);
                }
            }
            db.evenement.Remove(evenement);
            db.SaveChanges();
            return RedirectToAction("Manage", "Account");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        [HttpPost]
        public ActionResult ParticiperEvent(string eventID)
        {
            evenement evenement = db.evenement.Find(Convert.ToInt32(eventID));

            event_user ev_user = new event_user();

            ev_user.event_id = Convert.ToInt32(eventID);
            ev_user.UserId = (from i in db.UserProfile
                              where i.UserName == WebSecurity.CurrentUserName
                              select i.UserId).First();

            UserProfile u = (from i in db.UserProfile
                             where i.UserName == WebSecurity.CurrentUserName
                             select i).First();

            u.event_user.Add(ev_user);

            evenement.actual_people += 1;
            db.SaveChanges();
            return RedirectToAction("Index", "Home");
        }

        public ActionResult desinscrire(int id_event, int id_user)
        {
            evenement evenement = db.evenement.Find(id_event);


            event_user ev_user = (from i in db.event_user
                                  where i.event_id == id_event && i.UserId == id_user
                                  select i).First();


            UserProfile u = (from i in db.UserProfile
                             where i.UserId == id_user
                             select i).First();


            db.event_user.Remove(ev_user);
            evenement.actual_people -= 1;
            db.SaveChanges();
            return RedirectToAction("Index", "Home");
        }

    }
}