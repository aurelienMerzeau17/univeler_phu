using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using phu.Models;
using System.Web.Script.Serialization;
using System.Runtime.Serialization;
using GoogleMaps.LocationServices;
using System.Web.UI;

namespace phu.Controllers
{
    public class HomeController : Controller
    {
        private phu_bddEntities db = new phu_bddEntities();
        public ActionResult Index()
        {
            List<evenement> ev = new List<evenement>();

            ev = db.evenement.Where( i => i.validate == 1 && i.date_event >= DateTime.Now ).ToList();
            
            return View(ev);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";
            
            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        [HttpPost]
        public PartialViewResult PartialDetailEvent(string Evenement)
        {
            return PartialView("PartialDetailEvent");
        }
    }
}
