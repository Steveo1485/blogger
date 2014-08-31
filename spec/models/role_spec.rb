require 'spec_helper'

describe Role do

  it { should ensure_inclusion_of(:name).in_array([:user, :admin]) }

end