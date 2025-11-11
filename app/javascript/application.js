import { Application } from "@hotwired/stimulus"
import registerControllers from "./controllers"

const application = Application.start()
registerControllers(application)

export { application }

