using Granite.Widgets;

namespace RepositoriesManager {
public class WinnerView : Gtk.ScrolledWindow {

    public Welcome winner_view = new Welcome("The winner is...", "him" + "!");
    StackManager stackManager = StackManager.get_instance();

    public WinnerView(){
        winner_view.append("go-home", "Click here!", "To return to the list of names");
        winner_view.activated.connect ((option) => {
            switch (option) {		
                case 0:
                    stackManager.getStack().visible_child_name = "list-view";
                    break;
            }
        });

        this.add(winner_view);
    }

    public void setWinner(string winner){
        winner_view.subtitle = winner;
    }
}
}
