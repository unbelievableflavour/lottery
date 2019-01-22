using Granite.Widgets;

namespace Application {
public class ListBox : Gtk.ListBox {

    private EntryManager entry_manager = EntryManager.get_instance ();
    private StackManager stack_manager = StackManager.get_instance ();

    public void empty () {
        this.foreach ((ListBoxRow) => {
            this.remove (ListBoxRow);
        });
    }

    public void get_repositories (string search_word = "") {
        this.empty ();

        stack_manager.get_stack ().visible_child_name = "list-view";

        var entries = entry_manager.get_entries ();

        if (searchword_does_not_match_any_in_list (search_word, entries)) {
            stack_manager.get_stack ().visible_child_name = "not-found-view";
            return;
        }

        foreach (string entry in entries) {
            if (search_word == "") {
                this.add (new ListBoxRow (entry));
                continue;
            }

            if (search_word in entry) {
                this.add (new ListBoxRow (entry));
            }
        }

        this.show_all ();
    }

    private bool searchword_does_not_match_any_in_list (string search_word, string[] entries) {
        int match_count = 0;

        if (search_word == "") {
            return false;
        }

        foreach (string entry in entries) {
            if (search_word in entry) {
                match_count++;
            }
        }
        return match_count == 0;
    }
}
}
