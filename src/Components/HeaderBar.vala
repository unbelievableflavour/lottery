using Granite.Widgets;

namespace Application {
public class HeaderBar : Gtk.HeaderBar {

    ListManager listManager = ListManager.get_instance();
    StackManager stackManager = StackManager.get_instance();
    
    public HeaderBar(){

        Granite.Widgets.Utils.set_color_primary (this, Constants.BRAND_COLOR);

        var searchEntry = new Gtk.SearchEntry ();
        searchEntry.set_placeholder_text("Search names");
        searchEntry.set_tooltip_text("Search for names");
        searchEntry.search_changed.connect (() => {
            listManager.getList().getRepositories(searchEntry.text); 
        });

        var create_button = new Gtk.Button.from_icon_name ("contact-new", Gtk.IconSize.LARGE_TOOLBAR);
        create_button.set_tooltip_text("Add a new name");
        create_button.clicked.connect (() => {
            new AddEntry();
        });
        
        var pixbuf = new Gdk.Pixbuf.from_file_at_scale("/usr/share/pixmaps/lottery.crown.svg",24,24,true);
        var image = new Gtk.Image.from_pixbuf(pixbuf);

        var lottery_button = new Gtk.Button();
        lottery_button.set_image(image);
        lottery_button.set_tooltip_text("Randomly generate a winner");
        lottery_button.clicked.connect (() => {
            stackManager.showWinnerView();
        });

        var cheatsheet_button = new Gtk.Button.from_icon_name ("help-contents", Gtk.IconSize.LARGE_TOOLBAR);
        cheatsheet_button.set_tooltip_text("A list of available shortcuts");
        cheatsheet_button.clicked.connect (() => {
            new Cheatsheet ();
        });

        this.show_close_button = true;

        this.pack_start (create_button);
        this.pack_start (searchEntry);

        this.pack_end (cheatsheet_button);
        this.pack_end (lottery_button);
    }
}
}
