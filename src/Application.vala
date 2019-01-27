using Granite.Widgets;

namespace Application {
public class App:Granite.Application {

    public static MainWindow window = null;
    public static GLib.Settings settings;

    construct {
        application_id = Constants.APPLICATION_NAME;
        program_name = Constants.APPLICATION_NAME;
        settings = new GLib.Settings (Constants.APPLICATION_NAME);
    }

    protected override void activate () {
        new_window ();
    }

    public void new_window () {
        var stack_manager = StackManager.get_instance ();

        if (window != null) {
            window.present ();
            return;
        }

        weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
        default_theme.add_resource_path ("/com/github/bartzaalberg/lottery");

        window = new MainWindow (this);
        go_to_last_saved_position (window);
        go_to_last_saved_size (window);

        window.show_all ();
        stack_manager.get_stack ().visible_child_name = "welcome-view";
    }

    public static int main (string[] args) {
        var app = new Application.App ();
        return app.run (args);
    }

    private void go_to_last_saved_position (MainWindow main_window) {
        int window_x, window_y;
        settings.get ("window-position", "(ii)", out window_x, out window_y);
        if (window_x != -1 || window_y != -1) {
            window.move (window_x, window_y);
        }
    }

    private void go_to_last_saved_size (MainWindow main_window) {
        var rect = Gtk.Allocation ();

        settings.get ("window-size", "(ii)", out rect.width, out rect.height);
        window.set_allocation (rect);

        if (settings.get_boolean ("window-maximized")) {
            window.maximize ();
        }
    }
}
}

