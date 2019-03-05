using Granite.Widgets;

namespace Application {
public class HeaderBar : Gtk.HeaderBar {

    static HeaderBar? instance;

    ListManager list_manager = ListManager.get_instance ();
    StackManager stack_manager = StackManager.get_instance ();
    EntryManager entry_manager = EntryManager.get_instance ();

    public Gtk.SearchEntry search_entry = new Gtk.SearchEntry ();
    Gtk.Button create_button = new Gtk.Button.from_icon_name ("contact-new", Gtk.IconSize.LARGE_TOOLBAR);
    Gtk.Button import_button = new Gtk.Button.from_icon_name ("document-import", Gtk.IconSize.LARGE_TOOLBAR);
    Gtk.Button return_button = new Gtk.Button ();
    Gtk.Button lottery_button = new Gtk.Button ();

    HeaderBar () {
        Granite.Widgets.Utils.set_color_primary (this, Constants.BRAND_COLOR);

        generate_search_entry ();
        generate_create_button ();
        generate_import_button ();
        generate_return_button ();
        generate_choose_winner_button ();

        this.show_close_button = true;

        this.pack_start (return_button);
        this.pack_start (create_button);
        this.pack_start (import_button);
        this.pack_start (search_entry);

        this.pack_end (lottery_button);
    }

    public static HeaderBar get_instance () {
        if (instance == null) {
            instance = new HeaderBar ();
        }
        return instance;
    }

    private void generate_search_entry () {
        search_entry.set_placeholder_text (_("Search names"));
        search_entry.tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>F"}, _("Search for names"));
        search_entry.search_changed.connect (() => {
            list_manager.get_list ().get_repositories (search_entry.text);
        });
    }

    private void generate_choose_winner_button () {
        var icon = new Gtk.Image.from_icon_name ("lottery-crown", Gtk.IconSize.LARGE_TOOLBAR);
        lottery_button.set_image (icon);
        lottery_button.tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>W"}, _("Randomly generate a winner"));
        lottery_button.clicked.connect (() => {
            stack_manager.show_winner_view ();
        });

    }

    private void generate_create_button () {
        create_button.tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>A"}, _("Add a new name"));
        create_button.clicked.connect (() => {
            new AddEntry ();
        });
    }

    private void generate_import_button () {
        import_button.tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>I"}, _("Import names from CSV"));
        import_button.clicked.connect (import_names);
    }

    public void import_names () {
        var path = get_file_path ();

        if (path == "") {
            return;
        }

        var file = File.new_for_path (path);
        if (!file.query_exists ()) {
            new Alert (_("File doesnt exist"), _("File ") + file.get_path () + _(" doesn't exist"));
            return;
        }

        import_names_from_csv (file);
    }

    public void import_names_from_csv (File file) {
        try {
            var dis = new DataInputStream (file.read ());
            string line;
            // Read lines until end of file (null) is reached
            while ((line = dis.read_line (null)) != null) {
                string[] names = line.split (",");
                foreach (string name in names) {
                    if (name.strip () == "") {
                        continue;
                    }
                    entry_manager.add_entry (name);
                }
            }
        } catch (Error e) {
            error ("%s", e.message);
        }

        list_manager.get_list ().get_repositories ("");
    }

    private void generate_return_button () {
        return_button.label = _("Back");
        return_button.no_show_all = true;
        return_button.get_style_context ().add_class ("back-button");
        return_button.visible = false;
        return_button.clicked.connect (() => {
            stack_manager.get_stack ().visible_child_name = "list-view";
        });
    }

    public void show_buttons (bool answer) {
        search_entry.visible = answer;
        create_button.visible = answer;
        import_button.visible = answer;
        lottery_button.visible = answer;
    }

    public void show_return_button (bool answer) {
        return_button.visible = answer;
    }

    public string get_file_path () {

        // The FileChooserDialog:
        Gtk.FileChooserDialog chooser = new Gtk.FileChooserDialog (
                "Select your favorite file", null, Gtk.FileChooserAction.OPEN,
                "_Cancel",
                Gtk.ResponseType.CANCEL,
                "_Open",
                Gtk.ResponseType.ACCEPT);

        // Multiple files can be selected:
        chooser.select_multiple = false;

        // We are only interested in .snap files:
        Gtk.FileFilter filter = new Gtk.FileFilter ();
        chooser.set_filter (filter);
        filter.add_mime_type ("text/csv");

        // Add a preview widget:
        Gtk.Image preview_area = new Gtk.Image ();
        chooser.set_preview_widget (preview_area);
        chooser.update_preview.connect (() => {
            string uri = chooser.get_preview_uri ();
            // We only display local files:
            if (uri != null && uri.has_prefix ("file://") == true) {
                try {
                    Gdk.Pixbuf pixbuf = new Gdk.Pixbuf.from_file_at_scale (uri.substring (7), 150, 150, true);
                    preview_area.set_from_pixbuf (pixbuf);
                    preview_area.show ();
                } catch (Error e) {
                    preview_area.hide ();
                }
            } else {
                preview_area.hide ();
            }
        });

        string filePath = "";

        // Process response:
        if (chooser.run () == Gtk.ResponseType.ACCEPT) {
            SList<string> uris = chooser.get_uris ();

            foreach (unowned string uri in uris) {
                filePath = uri.replace ("file://", "");
            }
        }

        // Close the FileChooserDialog:
        chooser.close ();

        return filePath;
    }
}
}
