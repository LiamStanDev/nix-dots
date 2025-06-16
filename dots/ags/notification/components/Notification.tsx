import { GLib } from "astal";
import { Gtk, Astal } from "astal/gtk3";
import { type EventBox } from "astal/gtk3/widget";
import Notifd from "gi://AstalNotifd";

const time = (time: number, format = "%H:%M") =>
  GLib.DateTime.new_from_unix_local(time).format(format);

const urgency = (n: Notifd.Notification) => {
  const { LOW, NORMAL, CRITICAL } = Notifd.Urgency;
  switch (n.urgency) {
    case LOW:
      return "low";
    case CRITICAL:
      return "critical";
    case NORMAL:
    default:
      return "normal";
  }
};

type Props = {
  setup(self: EventBox): void;
  onHoverLost(self: EventBox): void;
  notification: Notifd.Notification;
};

export default function Notification(props: Props) {
  const { notification: n, onHoverLost, setup } = props;
  const { START, CENTER, END } = Gtk.Align;

  // Astal/GTK3's JSX container（e.g. `<box>` expect children is Widget[]
  return (
    <eventbox
      className={`Notification ${urgency(n)}`}
      setup={setup}
      onHoverLost={onHoverLost}
    >
      <box vertical>
        <box className="header">
          <label
            className="app-name"
            halign={START}
            label={n.appName || "Unknown"}
          />
          <label
            className="time"
            halign={END}
            label={time(n.time) || "Unknown"}
          />
          <button onClicked={() => n.dismiss()}>
            <icon icon="window-close-symbolic" />
          </button>
          <button>
            <icon></icon>
          </button>
        </box>

        <Gtk.Separator visible />

        <box className="content"></box>
      </box>
    </eventbox>
  );
}
