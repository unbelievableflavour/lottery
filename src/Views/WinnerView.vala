using Granite.Widgets;

namespace Application {
public class WinnerView : Gtk.ScrolledWindow {

    public Welcome winner_view = new Welcome("The winner is...", "him" + "!");

    public WinnerView(){
        this.add(winner_view);
    }

    public void setWinner(string winner){
        winner_view.subtitle = winner;
    }
}
}
