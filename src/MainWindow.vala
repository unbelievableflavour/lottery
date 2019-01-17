using Granite.Widgets;

namespace Application {
public class MainWindow : Gtk.Window{

    private ListManager listManager = ListManager.get_instance();
    private StackManager stackManager = StackManager.get_instance();

    private HeaderBar headerBar = HeaderBar.get_instance();

    public MainWindow (Gtk.Application application) {
        Object (application: application,
                resizable: true,
                height_request: Constants.APPLICATION_HEIGHT,
                width_request: Constants.APPLICATION_WIDTH);
    }

    construct {
        set_titlebar (headerBar);

        stackManager.loadViews(this);

        listManager.getList().getRepositories("");

        stackManager.getStack().visible_child_name = "welcome-view";

        addShortcuts();
    }

    private void addShortcuts(){
        key_press_event.connect ((e) => {
            switch (e.keyval) {
                case Gdk.Key.a:
                    if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                        new AddEntry();
                    }
                    break;
                case Gdk.Key.i:
                    if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                        headerBar.importNames();
                    }
                    break;
                case Gdk.Key.w:
                    if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                        stackManager.showWinnerView();
                    }
                    break;
                case Gdk.Key.h:
                    if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                        new Cheatsheet();
                    }
                    break;
                case Gdk.Key.f:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                    headerBar.searchEntry.grab_focus();
                  }
                  break;
                case Gdk.Key.q:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                    this.destroy();
                  }
                  break;
            }

            return false;
        });
    }
}
}
