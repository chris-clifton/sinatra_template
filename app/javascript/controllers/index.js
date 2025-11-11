import HomeController from "./home_controller.js"

export default function registerControllers(application) {
  application.register("home", HomeController)
}

