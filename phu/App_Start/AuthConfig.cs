using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Web.WebPages.OAuth;
using phu.Models;

namespace phu
{
    public static class AuthConfig
    {
        public static void RegisterAuth()
        {
            // Pour permettre aux utilisateurs de ce site de se connecter à l’aide de leur compte à partir d’autres sites tels que Microsoft, Facebook et Twitter,
            // vous devez mettre à jour ce site. Pour plus d’informations, consultez la page http://go.microsoft.com/fwlink/?LinkID=252166

            //OAuthWebSecurity.RegisterMicrosoftClient(
            //    clientId: "",
            //    clientSecret: "");

            //OAuthWebSecurity.RegisterTwitterClient(
            //    consumerKey: "",
            //    consumerSecret: "");

            OAuthWebSecurity.RegisterFacebookClient(
                appId: "1488446718037695",
                appSecret: "6db9ab53b2e0327d05917ee14987263d");

            //OAuthWebSecurity.RegisterGoogleClient();
        }
    }
}
