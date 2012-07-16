require 'spec_helper'

describe Attachment do
  it {should belong_to :project}
  it {should validate_presence_of :project_id}
  it {should validate_presence_of :file}  
end
