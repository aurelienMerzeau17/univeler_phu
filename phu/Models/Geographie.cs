using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace phu.Models
{
    public class Geographie
    {
        public string adresse { get; set; }
        public int cp { get; set; }
        public string city { get; set; }
        public int event_id { get; set; }

        public Geographie()
        {
        }
    }
}