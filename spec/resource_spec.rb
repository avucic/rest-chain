describe "Resource" do


  it "should respond to dynamic method" do
    { :id => "5" }.to_rest_chain.should respond_to(:id)
    { :id => "5" }.should_not respond_to(:id)
  end


  it "should get attribute value" do
    resource = { :title => "title" }.to_rest_chain
    resource.title.should == "title"
  end


  it "should reload self" do
    resource = { 'properties' => { 'title' => 'old_title' } }.to_rest_chain
    resource.title.should == 'old_title'
    resource.write_attribute('title', 'new_title')
    resource.title.should == 'new_title'
    resource.reload.title.should == 'old_title'
  end


  it "should pair client" do
    google = { 'href' => 'http://www.google.com' }.to_rest_chain
    yahoo  = { 'href' => 'http://www.yahoo.com' }.to_rest_chain
    google.pair(:yahoo, yahoo)
    google.context.pairs.should include(:yahoo)
  end

  it "should pair and respond to the paired client method" do
    google = { 'href' => 'http://www.google.com' }.to_rest_chain
    yahoo  = { 'href' => 'http://www.yahoo.com', 'properties' => { 'name' => "yahoo" } }.to_rest_chain
    google.pair(:yahoo, yahoo)
    google.yahoo.name.should == "yahoo"
  end

end



