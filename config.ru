require './config/environment'

use Rack::MethodOverride
use UsersController
use CompaniesController
run ApplicationController