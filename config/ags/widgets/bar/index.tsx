import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"

import Workspaces from "./modules/workspaces"
import Client from "./modules/client"
import Clock from "./modules/clock"
import Tray from "./modules/tray"
import Audio from "./modules/audio"
import Spotify from "./modules/spotify"
import Network from "./modules/network"

const NixOS = () => 
  <image iconName="nix-snowflake"
    cssClasses={["widget", "os"]} pixelSize={20}/>

type BarSeparatorProps = {
  scan_direction: string
}
const BarSeparator = ({ scan_direction }: BarSeparatorProps) => {
  function _handleSiblingVisibility(self: Gtk.Widget, sibling_visibility: boolean) {
    if (sibling_visibility) {
      self.set_visible(true)
    } else {
      self.set_visible(false)
    }
  }
  function setup(self: Gtk.Widget): void {
    if (!scan_direction) return;
    self.connect('map', () => {
      const sibling = scan_direction === "left" ? self.get_prev_sibling() : self.get_next_sibling();
      if (!sibling) return;

      const sibling_visible = sibling.get_visible()
      _handleSiblingVisibility(self, sibling_visible)
      sibling.connect("notify::visible", () => {
        _handleSiblingVisibility(self, sibling.get_visible())
      })
    })
  }

  return <label visible cssClasses={["widget", "separator"]} $={setup} label=""/>
}

const ModulesLeft = () => 
  <box
    name="modules-left">
    <NixOS/>
    <BarSeparator scan_direction="left"/>
    <Workspaces/>
    <BarSeparator scan_direction="right"/>
    <Client/>
  </box>

const ModulesCenter = () =>
  <box visible
    name="modules-center">
    <Clock/>
    <BarSeparator scan_direction="right"/>
    <Spotify />
  </box>

const ModulesRight = () =>
  <box visible
    name="modules-right">
    <Network/>
    <Audio/>
    <Tray/>
  </box>

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  return (
    <window
      visible
      name="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox hexpand>
        <ModulesLeft _type="start"/>
        <ModulesCenter _type="center"/>
        <ModulesRight _type="end"/>
      </centerbox>
    </window>
  )
}
