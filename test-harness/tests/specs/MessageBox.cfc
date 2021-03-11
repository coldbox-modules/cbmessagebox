/**
 * MessageBox tests
 */
component extends="coldbox.system.testing.BaseTestCase" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "Messagebox Module", function(){
			beforeEach( function( currentSpec ){
				setup();
				m = getInstance( "MessageBox@cbMessageBox" );
			} );

			it( "can be instantiated via WireBox", function(){
				expect( m ).toBeComponent();
			} );

			var types = [ "success", "info", "warn", "error" ];
			for ( var thisType in types ) {
				it(
					title = "can set #thisType# messages",
					data  = { type : thisType },
					body  = function( data ){
						m.setMessage( data.type, "test message" );
						expect( m.isEmptyMessage() ).toBeFalse();
						expect( m.getMessage().message ).toBe( "test message" );
						expect( m.getMessage().type ).toBe( data.type );
					}
				);
			}

			it( "can append messages", function(){
				m.clearMessage();
				m.info( "hello luis" );
				m.append( "pio" );
				expect( m.isEmptyMessage() ).toBeFalse();
				expect( m.getMessage().message ).toBe( "hello luis<br>pio" );
			} );

			it( "can append messages with separators", function(){
				m.clearMessage();
				m.info( "hello luis" );
				m.append( message: "pio", separator: "<hr>" );
				expect( m.isEmptyMessage() ).toBeFalse();
				expect( m.getMessage().message ).toBe( "hello luis<hr>pio" );
			} );

			it( "can append arrays", function(){
				m.clearMessage();
				m.info( "hello luis" );
				m.append( [ " unit test" ] );
				expect( m.getMessage().message ).toBe( "hello luis<br> unit test" );
			} );

			it( "can prepend arrays", function(){
				m.clearMessage();
				m.info( "hello luis" );
				m.prepend( [ "unit test" ] );
				expect( m.getMessage().message ).toBe( "unit test<br>hello luis" );
			} );

			it( "can clear messages", function(){
				m.clearMessage();
				expect( m.isEmptyMessage() ).toBeTrue();
			} );

			it( "can render out messages", function(){
				m.setMessage( "info", "Hola!" );
				var html = m.renderIt();
				expect( html ).toInclude( "Hola!" ).toInclude( "info" );
			} );
		} );
	}

}
