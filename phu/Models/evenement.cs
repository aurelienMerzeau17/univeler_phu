//------------------------------------------------------------------------------
// <auto-generated>
//    Ce code a été généré à partir d'un modèle.
//
//    Des modifications manuelles apportées à ce fichier peuvent conduire à un comportement inattendu de votre application.
//    Les modifications manuelles apportées à ce fichier sont remplacées si le code est régénéré.
// </auto-generated>
//------------------------------------------------------------------------------

namespace phu.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class evenement
    {
        public evenement()
        {
            this.event_user = new HashSet<event_user>();
        }
    
        public int event_id { get; set; }
        public string name { get; set; }
        public int localisation_id { get; set; }
        public int max_people { get; set; }
        public int actual_people { get; set; }
        public string description { get; set; }
        public int validate { get; set; }
        public System.DateTime date_event { get; set; }
        public int UserId { get; set; }
    
        public virtual ICollection<event_user> event_user { get; set; }
        public virtual localisation localisation { get; set; }
        public virtual UserProfile UserProfile { get; set; }
    }
}
