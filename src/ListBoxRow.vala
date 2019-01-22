using Granite.Widgets;

namespace Application {
public class ListBoxRow : Gtk.ListBoxRow {

    private Gtk.Image delete_image = new Gtk.Image.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
    private Gtk.Image icon = new Gtk.Image.from_icon_name ("avatar-default-symbolic", Gtk.IconSize.DND);
    private EntryManager entry_manager = EntryManager.get_instance ();
    private ListManager list_manager = ListManager.get_instance ();

    public ListBoxRow (string entry) {

        var delete_button = generate_delete_button (entry);

        var label = new Gtk.Label (entry);
        var row = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
        row.margin = 12;
        row.add (icon);
        row.add (label);
        row.pack_end (delete_button, false, false);
        this.add (row);
    }

    public Gtk.EventBox generate_delete_button (string entry) {
        var delete_button = new Gtk.EventBox ();
        delete_button.add (delete_image);
        delete_button.set_tooltip_text (_("Remove this name"));
        delete_button.button_press_event.connect (() => {
            entry_manager.remove_entry (entry);
            list_manager.get_list ().get_repositories ("");
            return true;
        });

        return delete_button;
    }
}
}
