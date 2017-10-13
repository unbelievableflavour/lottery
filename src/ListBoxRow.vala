using Granite.Widgets;

namespace RepositoriesManager {
public class ListBoxRow : Gtk.ListBoxRow {

    private Gtk.Image edit_image = new Gtk.Image.from_icon_name ("document-properties-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
    private Gtk.Image delete_image = new Gtk.Image.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
    private Gtk.Image icon = new Gtk.Image.from_icon_name ("avatar-default", Gtk.IconSize.DND);
    private EntryManager entryManager = EntryManager.get_instance();
    private ListManager listManager = ListManager.get_instance();

    public ListBoxRow (string entry){

        var delete_button = generateDeleteButton(entry);
        var edit_button = generateEditButton(entry);

        var label  = new Gtk.Label(entry);
        var row = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
        row.margin = 12;
        row.add(icon);
        row.add (label);
        //row.pack_end (edit_button, false, false);
        row.pack_end (delete_button, false, false);
        this.add (row);
    }

    public Gtk.EventBox generateDeleteButton(string entry){
        var delete_button = new Gtk.EventBox();
        delete_button.add(delete_image);
        delete_button.set_tooltip_text("Remove this name");
        delete_button.button_press_event.connect (() => {
            entryManager.removeEntry(entry);
            listManager.getList().getRepositories("");
            return true;
        });

        return delete_button;
    }

    public Gtk.EventBox generateEditButton(string entry){
        var edit_button = new Gtk.EventBox();
        edit_button.add(edit_image);
        edit_button.set_tooltip_text("Edit this name");
        edit_button.button_press_event.connect (() => {
           // stackManager.setEditBookmark(bookmark);
           // stackManager.getStack().visible_child_name = "edit-bookmark-view";
            return true;
        });

        return edit_button;
    }
}
}
