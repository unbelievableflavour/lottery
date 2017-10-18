using Granite.Widgets;

namespace Application {
public class HeaderBar : Gtk.HeaderBar {

    ListManager listManager = ListManager.get_instance();
    StackManager stackManager = StackManager.get_instance();
   
    Gtk.SearchEntry searchEntry = new Gtk.SearchEntry ();
    Gtk.Button create_button = new Gtk.Button.from_icon_name ("contact-new", Gtk.IconSize.LARGE_TOOLBAR);
    Gtk.Button return_button = new Gtk.Button ();
    Gtk.Button lottery_button = new Gtk.Button();

    public HeaderBar(){
        Granite.Widgets.Utils.set_color_primary (this, Constants.BRAND_COLOR);
       
        searchEntry.set_placeholder_text("Search names");
        searchEntry.set_tooltip_text("Search for names");
        searchEntry.search_changed.connect (() => {
            listManager.getList().getRepositories(searchEntry.text); 
        });
      
        create_button.set_tooltip_text("Add a new name");
        create_button.clicked.connect (() => {
            new AddEntry();
        });

        return_button.label = "Back";
        return_button.no_show_all = true;
        return_button.get_style_context ().add_class ("back-button");
        return_button.visible = false;
        return_button.clicked.connect (() => {
            showReturnButton(false);
            showButtons(true);
            stackManager.getStack().visible_child_name = "list-view";
        });

        var pixbuf = new Gdk.Pixbuf.from_file_at_scale("/usr/share/pixmaps/lottery.crown.svg",24,24,true);
        var image = new Gtk.Image.from_pixbuf(pixbuf);        
        lottery_button.set_image(image);
        lottery_button.set_tooltip_text("Randomly generate a winner");
        lottery_button.clicked.connect (() => {
            stackManager.showWinnerView();            
            showReturnButton(true);
            showButtons(false);
            
        });

        var cheatsheet_button = new Gtk.Button.from_icon_name ("help-contents", Gtk.IconSize.LARGE_TOOLBAR);
        cheatsheet_button.set_tooltip_text("A list of available shortcuts");
        cheatsheet_button.clicked.connect (() => {
            new Cheatsheet ();
        });

        this.show_close_button = true;

        this.pack_start (return_button);
        this.pack_start (create_button);
        this.pack_start (searchEntry);

        this.pack_end (cheatsheet_button);
        this.pack_end (lottery_button);
    }

    public void showButtons(bool answer){
        searchEntry.visible = answer;
        create_button.visible = answer;
        create_button.visible = answer;
        lottery_button.visible = answer;
    }

    public void showReturnButton(bool answer){
        return_button.visible = answer;
    }
}
}
