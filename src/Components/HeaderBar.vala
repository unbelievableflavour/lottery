using Granite.Widgets;

namespace RepositoriesManager {
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

        var create_button = new Gtk.Button.with_label ("Add");
        create_button.margin_end = 12;
        create_button.clicked.connect (() => {
            new AddEntry();
        });

        var lottery_button = new Gtk.Button.with_label ("Lottery");
        lottery_button.margin_end = 12;
        lottery_button.clicked.connect (() => {
            new Winner();            
        });

        var button_box = new Gtk.ButtonBox (Gtk.Orientation.HORIZONTAL);
        button_box.set_layout (Gtk.ButtonBoxStyle.START);
        button_box.pack_start (create_button);
      
        this.show_close_button = true;

        this.pack_start (button_box);
        this.pack_end (searchEntry);
        this.pack_end (lottery_button);
    }
}
}
