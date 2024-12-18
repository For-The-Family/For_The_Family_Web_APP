# region: 1 - Import Section Starts ##########
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from dotenv import load_dotenv
import pyrebase


from .blueprints.front_page.routes import front_page_bp
from .blueprints.test_js.routes import test_js_bp
from .blueprints.test_css.routes import test_css_bp
from .blueprints.test_sql.routes import test_sql_bp
from .blueprints.play_areas.routes import play_areas_bp
from .blueprints.play_areas.kindergartens.routes import kindergartens_bp
from .blueprints.play_areas.gradeschools.routes import gradeschools_bp
from .blueprints.play_areas.playgrounds.routes import playgrounds_bp
from .blueprints.refreshments.restaurants.routes import restaurants_bp

# endregion - Import Section Ends ##########
# region: 2 - ########## app creation Starts ##########
def create_app():
    app = Flask(__name__)
    # region: 2.1 - ########## Database Configuration Starts ##########
    #app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://website_reader:Parlor-Ellipse-Grappling-Rival-Daylight-Backtalk7@/database_name'
    # endregion - ########## Database Configuration Ends ##########
    # region: 2.2 - ########## Blueprint Registration Starts ##########
    app.register_blueprint(front_page_bp)
    app.register_blueprint(test_js_bp, url_prefix='/test_js')
    app.register_blueprint(test_css_bp, url_prefix='/test_css')
    app.register_blueprint(test_sql_bp, url_prefix='/test_sql')
    app.register_blueprint(play_areas_bp, url_prefix='/play_areas')
    app.register_blueprint(kindergartens_bp, url_prefix='/kindergartens')
    app.register_blueprint(gradeschools_bp, url_prefix='/gradeschools')
    app.register_blueprint(playgrounds_bp, url_prefix='/playgrounds')
    app.register_blueprint(restaurants_bp, url_prefix='/restaurants')
    # endregion - ########## Blueprint Registration Ends ##########
    return app
# endregion - ########## app creation Ends ##########