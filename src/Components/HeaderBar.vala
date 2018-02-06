using Granite.Widgets;

namespace Application {
public class HeaderBar : Gtk.HeaderBar {
    
    static HeaderBar? instance;

    ListManager listManager = ListManager.get_instance();
    StackManager stackManager = StackManager.get_instance();
   
    public Gtk.SearchEntry searchEntry = new Gtk.SearchEntry ();
    Gtk.Button cheatsheet_button = new Gtk.Button.from_icon_name ("open-menu", Gtk.IconSize.LARGE_TOOLBAR);
    Gtk.Button create_button = new Gtk.Button.from_icon_name ("contact-new", Gtk.IconSize.LARGE_TOOLBAR);
    Gtk.Button return_button = new Gtk.Button ();
    Gtk.Button lottery_button = new Gtk.Button();

    HeaderBar() {
        Granite.Widgets.Utils.set_color_primary (this, Constants.BRAND_COLOR);
        
        generateSearchEntry();
        generateCreateButton();
        generateReturnButton();
        generateChooseWinnerButton();
        generateCheatsheetButton();

        this.show_close_button = true;

        this.pack_start (return_button);
        this.pack_start (create_button);
        this.pack_start (searchEntry);

        this.pack_end (cheatsheet_button);
        this.pack_end (lottery_button);
    }
 
    public static HeaderBar get_instance() {
        if (instance == null) {
            instance = new HeaderBar();
        }
        return instance;
    }    
    
    private void generateCheatsheetButton(){
        cheatsheet_button.no_show_all = true;
        cheatsheet_button.set_tooltip_text("A list of available shortcuts");
        cheatsheet_button.clicked.connect (() => {
            new Cheatsheet ();
        });
    }

    private void generateSearchEntry(){
        searchEntry.set_placeholder_text("Search names");
        searchEntry.set_tooltip_text("Search for names");
        searchEntry.search_changed.connect (() => {
            listManager.getList().getRepositories(searchEntry.text); 
        });
    }

    private void generateChooseWinnerButton(){
        var icon = new Gtk.Image.from_icon_name ("lottery-crown", Gtk.IconSize.LARGE_TOOLBAR);
        lottery_button.set_image(icon);
        lottery_button.set_tooltip_text("Randomly generate a winner");
        lottery_button.clicked.connect (() => {
            stackManager.showWinnerView();    
        });

    }

    private void generateCreateButton(){
        create_button.set_tooltip_text("Add a new name");
        create_button.clicked.connect (() => {
            new AddEntry();
        });
    }

    private void generateReturnButton(){
        return_button.label = "Back";
        return_button.no_show_all = true;
        return_button.get_style_context ().add_class ("back-button");
        return_button.visible = false;
        return_button.clicked.connect (() => {
            stackManager.getStack().visible_child_name = "list-view";
        });
    }

    public void showButtons(bool answer){
        searchEntry.visible = answer;
        create_button.visible = answer;
        create_button.visible = answer;
        lottery_button.visible = answer;
        cheatsheet_button.visible = answer;
    }

    public void showReturnButton(bool answer){
        return_button.visible = answer;
    }
}
}
