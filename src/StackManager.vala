namespace RepositoriesManager {
public class StackManager : Object {
    
    static StackManager? instance;
    EntryManager entryManager = EntryManager.get_instance();
    
    private Gtk.Stack stack;
    private const string LIST_VIEW_ID = "list-view";
    private const string NOT_FOUND_VIEW_ID = "not-found-view";
    private const string WELCOME_VIEW_ID = "welcome-view";

   WinnerView winnerView;

    // Private constructor
    StackManager() {
        stack = new Gtk.Stack ();
        stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;
    }
 
    // Public constructor
    public static StackManager get_instance() {
        if (instance == null) {
            instance = new StackManager();
        }
        return instance;
    }

    public Gtk.Stack getStack() {
        return this.stack;
    }

    public void loadViews(Gtk.Window window){
        winnerView = new WinnerView();

        stack.add_named (new ListView(), LIST_VIEW_ID);
        stack.add_named (new NotFoundView(), NOT_FOUND_VIEW_ID);
        stack.add_named (new WelcomeView(), WELCOME_VIEW_ID);
        stack.add_named (winnerView, "winner-view");

        window.add(stack);
        window.show_all();
    }

    public void showWinnerView(){
        if(entryManager.getEntries().length == 0){
                new Alert("Cannot choose a winner yet", "No names have been added yet");
                return;            
        }
        winnerView.setWinner(entryManager.getWinner());
        this.getStack().visible_child_name = "winner-view";
    }
}
}
