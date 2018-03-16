require './config/environment'

use Rack::MethodOverride
use UsersController
use CompaniesController
use ContactsController
use PostingsController
run ApplicationController