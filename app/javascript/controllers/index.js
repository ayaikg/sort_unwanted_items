// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import IconController from "./icon_controller"
application.register("icon", IconController)

import LinkController from "./link_controller"
application.register("link", LinkController)

import ModalController from "./modal_controller"
application.register("modal", ModalController)

import TabController from "./tab_controller"
application.register("tab", TabController)
