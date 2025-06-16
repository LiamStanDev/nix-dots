import { bind, timeout, Variable } from "astal";
import { Subscribable } from "astal/binding";
import { Astal, Gdk, Gtk } from "astal/gtk3";
import Notifd from "gi://AstalNotifd";
import Notification from "./Notification";

const TIMEOUT_DELAY = 5000;

class NotifiationMap implements Subscribable {
  // keep track of id widget pairs
  private map: Map<number, Gtk.Widget> = new Map();

  // subscribers
  private var: Variable<Array<Gtk.Widget>> = Variable([]);

  private notify() {
    this.var.set([...this.map.values()].reverse());
  }

  constructor() {
    const notifd = Notifd.get_default();

    notifd.connect("notified", (_, id) => {
      const n = Notification({
        notification: notifd.get_notification(id)!,

        onHoverLost: () => {
          /*this.delete(id)*/
        },

        setup: () =>
          timeout(TIMEOUT_DELAY, () => {
            this.delete(id);
          }),
      });

      this.set(id, n);
    });

    notifd.connect("resolved", (_, id) => {
      this.delete(id);
    });
  }

  private set(key: number, value: Gtk.Widget) {
    this.map.get(key)?.destroy();
    this.map.set(key, value);
    this.notify();
  }

  private delete(key: number) {
    this.map.get(key)?.destroy();
    this.map.delete(key);
    this.notify();
  }

  get(): Gtk.Widget[] {
    return this.var.get();
  }

  subscribe(callback: (list: Array<Gtk.Widget>) => void) {
    return this.var.subscribe(callback);
  }
}

export default function NotificationPopups(gdkmonitor: Gdk.Monitor) {
  const { TOP, RIGHT } = Astal.WindowAnchor;
  const notifs = new NotifiationMap();

  return (
    <window
      className="NotificationPopups"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | RIGHT}
    >
      <box vertical>{bind(notifs)}</box>
    </window>
  );
}
