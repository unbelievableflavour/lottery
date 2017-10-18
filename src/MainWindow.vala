using Granite.Widgets;

namespace Application {
public class MainWindow : Gtk.Window{

    private ListManager listManager = ListManager.get_instance();
    private StackManager stackManager = StackManager.get_instance();

    private HeaderBar headerBar = new HeaderBar();

    construct {
        set_default_size(200, 810);
        set_titlebar (headerBar);

        stackManager.loadViews(this);

        listManager.getList().getRepositories("");

        stackManager.getStack().visible_child_name = "welcome-view";

        key_press_event.connect ((e) => { 
            switch (e.keyval) { 
                case Gdk.Key.a:
                    if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {  
                        new AddEntry(); 
                    } 
                    break;
                case Gdk.Key.w:
                    if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {  
                        stackManager.showWinnerView();
                        headerBar.showReturnButton(true);
                        headerBar.showButtons(false);
                    } 
                    break;
                case Gdk.Key.h:
                    if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {  
                        new Cheatsheet(); 
                    }
                    break;
            }

            return false; 
        });
    }
}
}
