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
    
    public partial class event_user
    {
        public int Id { get; set; }
        public int event_id { get; set; }
        public int UserId { get; set; }
    
        public virtual evenement evenement { get; set; }
        public virtual UserProfile UserProfile { get; set; }
    }
}
