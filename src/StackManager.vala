namespace Application {
public class StackManager : Object {

    static StackManager? instance;
    EntryManager entry_manager = EntryManager.get_instance ();

    private Gtk.Stack stack;
    private const string LIST_VIEW_ID = "list-view";
    private const string NOT_FOUND_VIEW_ID = "not-found-view";
    private const string WELCOME_VIEW_ID = "welcome-view";
    private const string WINNER_VIEW_ID = "winner-view";

   WinnerView winner_view;

    // Private constructor
    StackManager () {
        stack = new Gtk.Stack ();
        stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;
    }

    // Public constructor
    public static StackManager get_instance () {
        if (instance == null) {
            instance = new StackManager ();
        }
        return instance;
    }

    public Gtk.Stack get_stack () {
        return this.stack;
    }

    public void load_views (Gtk.Window window) {
        winner_view = new WinnerView ();

        stack.add_named (new ListView (), LIST_VIEW_ID);
        stack.add_named (new NotFoundView (), NOT_FOUND_VIEW_ID);
        stack.add_named (new WelcomeView (), WELCOME_VIEW_ID);
        stack.add_named (winner_view, WINNER_VIEW_ID);

        stack.notify["visible-child"].connect (() => {
            var header_bar = HeaderBar.get_instance ();

            if (stack.get_visible_child_name () == WELCOME_VIEW_ID) {
                header_bar.show_return_button (false);
                header_bar.show_buttons (true);
            }

            if (stack.get_visible_child_name () == NOT_FOUND_VIEW_ID) {
                header_bar.show_return_button (false);
                header_bar.show_buttons (true);
            }

            if (stack.get_visible_child_name () == LIST_VIEW_ID) {
                header_bar.show_return_button (false);
                header_bar.show_buttons (true);
            }
            if (stack.get_visible_child_name () == WINNER_VIEW_ID) {
                header_bar.show_return_button (true);
                header_bar.show_buttons (false);
            }
        });

        window.add (stack);
    }

    public void show_winner_view () {
        if (entry_manager.get_entries ().length == 0) {
            new Alert (_("Cannot choose a winner yet"), _("No names have been added yet"));
            return;
        }
        winner_view.set_winner (entry_manager.get_winner ());
        this.get_stack ().visible_child_name = "winner-view";
    }
}
}
