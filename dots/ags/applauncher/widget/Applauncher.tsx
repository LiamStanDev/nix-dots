import Apps from "gi://AstalApps";
import { Variable } from "astal";
import { App, Astal, Gdk, Gtk } from "astal/gtk3";

const MAX_ITEMS = 8;

function hide() {
  App.get_window("launcher")!.hide();
}

export default function Applauncher() {
  const { CENTER } = Gtk.Align;

  const apps = new Apps.Apps();
  const text = Variable("");
  const width = Variable(1000);

  const onEnter = () => {
    apps.fuzzy_query(text.get())?.[0].launch();
    hide();
  };

  return (
    <window
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.ON_DEMAND}
      application={App}
      onShow={(self) => {
        text.set("");
        width.set(self.get_current_monitor().workarea.width);
      }}
      onKeyPressEvent={function (self, event: Gdk.Event) {
        if (event.get_keyval()[1] === Gdk.KEY_Escape) self.hide();
      }}
    >
      <box>
        <eventbox widthRequest={width((w) => w / 2)} expand onClick={hide} />
        <box hexpand={false} vertical>
          <eventbox heightRequest={100} onClick={hide} />
          <box widthRequest={500} className="Applauncher" vertical>
            <entry
              placeholderText="Search"
              text={text()}
              onChanged={(self) => text.set(self.text)}
              onActivate={onEnter}
            />
            <></>
          </box>
        </box>
      </box>
    </window>
  );
}
