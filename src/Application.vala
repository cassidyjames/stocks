/*
* Copyright (c) 2020 Your Organization (https://brendanperry.me)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Author <bperry@hey.com>
*/

public class Application : Gtk.Application {
    public Application () {
        Object (
            application_id: "com.github.brendanperry.stocks",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }
    
    Gtk.Window landing_page;
    Gtk.Window main_page;

    protected override void activate () {
        var css_provider = new Style().GetCssProvider ();

        Gtk.StyleContext.add_provider_for_screen (
            Gdk.Screen.get_default (),
            css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );
        
        landing_page = new LandingPage (this);
        main_page = new MainPage (this);
        
        var api_key = new ApiKey ();

        if (api_key.Get () == "no-key-found") {
            add_window (landing_page);
            landing_page.show_all ();
        } else {
            add_window (main_page);
            main_page.show_all ();
        }
    }
    
    public void OpenMain () {
        remove_window (landing_page);
        landing_page.destroy ();
        
        main_page = new MainPage (this);
        add_window (main_page);
        main_page.show_all ();
    }
    
    public void OpenLanding () {
        remove_window (main_page);
        main_page.destroy ();
        
        landing_page = new LandingPage (this);
        add_window (landing_page);
        landing_page.show_all ();
    }

    public static int main (string[] args) {
        return new Application ().run (args);
    }
}


