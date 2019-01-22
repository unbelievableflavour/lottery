using Granite.Widgets;

namespace Application {
public class WinnerView : Gtk.ScrolledWindow {

    public Welcome winner_view = new Welcome (_("The winner is"), _("him") + "!");

    public WinnerView () {
        this.add (winner_view);
    }

    public void set_winner (string winner) {
        winner_view.subtitle = winner;
    }
}
}
