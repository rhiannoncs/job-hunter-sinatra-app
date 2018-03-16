require './config/environment'

use Rack::MethodOverride
use UsersController
use CompaniesController
use ContactsController
run ApplicationController