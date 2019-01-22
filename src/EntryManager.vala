using Granite.Widgets;

namespace Application {
public class EntryManager : Gtk.ListBox {

    static EntryManager? instance;
    string[] entries = new string[0];

    EntryManager () {
    }

    public static EntryManager get_instance () {
        if (instance == null) {
            instance = new EntryManager ();
        }
        return instance;
    }

    public string[] get_entries () {
        return entries;
    }

    public void add_entry (string entry) {
        entries += entry;
    }

    public void remove_entry (string removed_entry) {
        string[] new_list = new string[0];

        foreach (string entry in entries) {
           if (entry != removed_entry) {
                new_list += entry;
           }
        }

        entries = new_list;
    }

    public string get_winner () {
        int random_index = GLib.Random.int_range (0, entries.length);
        return entries[random_index];
    }
}
}
