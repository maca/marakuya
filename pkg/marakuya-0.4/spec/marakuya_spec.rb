require File.dirname(__FILE__) + '/../lib/marakuya'
require 'spec'

describe 'Marakuya' do
  def md str, opts = {}
    Marakuya.new( str, opts ).to_html
  end
  
  before do
    @str = 'I like maracuya'
    @m   = Marakuya.new( @str )
    @rd  = @m.instance_variable_get(:@rdisc)
  end
  
  describe 'Instatiation' do
    it "instantiate RDiscount" do
      @rd.should be_instance_of( RDiscount )
      @rd.text.should == @str
    end
    
    it "should set defaults" do
      @rd.smart.should be_true
      @rd.filter_html.should be_true
      @rd.fold_lines.should be_nil
      @rd.filter_styles.should be_nil
      @rd.fold_lines.should be_nil
      @rd.generate_toc.should be_nil
    end
    
    it "should override defaults" do
      m = Marakuya.new( @str, :filter_html => false )
      m.instance_variable_get(:@rdisc).filter_html.should be_true
    end
  end
  
  describe 'Allowed' do
    shared_examples_for 'markdown parser' do
      it "should allow explicit breaks" do
        markdown( "<br>\n   <br/>    \n<br />" ).should =~ %r{<br />\n<br />\n<br />\n}
      end

      it "should convert markdown" do
        markdown("Foo\n\nBar").should == "<p>Foo</p>\n\n<p>Bar</p>\n"
      end

      describe 'links' do
        it "should allow markdowns syntax for hyperlinking" do
          markdown("Hello [an example](http://example.com/ 'Title').").should =~ %r{<a href="http://example.com/" title="Title">an example</a>}
        end

        it "should allow HTML syntax for hyperlinking" do
          markdown("Hello <a href='http://example.com/path/to/file.php'>An example</a>.").should =~ %r{<a href='http://example.com/path/to/file.php'>An example</a>}
        end

        it "should not allow HTML syntax for hyperlinking when it contains an on* attribute" # do
         #          markdown("Hello <a href='http://example.com' onclick='alert(\"hello!\"); '>An example</a>.").should =~ %r{<a href='http://example.com'>An example</a>}
         #        end

        it "should auto hyperlink URLs" do
          markdown("Hello http://http://example.com/path/to/file.php. Adios").should == %{<p>Hello <a href="http://http://example.com/path/to/file.php">http://http://example.com/path/to/file.php</a>. Adios</p>\n}
        end
        
        it "should convert newlines to <br />" do
          markdown("hello\nworld\n\nGoodbye\ncruel\nworld").should == "<p>hello<br />\nworld</p>\n\n<p>Goodbye<br />\ncruel<br />\nworld</p>\n"
        end
      end

      # describe 'attributes' do
      #         it "should allow id in pragraph" do
      #           markdown("plain\n\nwith id{id: paragaph}").should == %{<p>plain</p>\n\n<p id="paragraph">with id</p>}
      #         end
      #         
      #         # it "should allow id for list and list item" do
      #         #   p markdown(%{* list item\n* list item 2{class: last_item}\n{id: list}}).inspect
      #         # end
      #       end
    end
    
    describe 'it has html filter' do
      alias :markdown :md
      it_should_behave_like "markdown parser"
    end
    
    describe "it doesn't have html filter" do
      def markdown str
        md str, :filter_html => false
      end
      it_should_behave_like "markdown parser"
    end
  end
  
end
