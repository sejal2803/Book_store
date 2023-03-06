require 'rails_helper'
RSpec.describe 'routes for Books', type: :routing do
  it 'routes GET /books to the books#index action' do
    expect(get: '/books').to route_to('books#index')
  end
  
  it 'routes GET /books/:id to the books#show action' do
    expect(get: '/books/1').to route_to('books#show', id: '1')
  end
  
  it 'routes POST /books to the books#create action' do
    expect(post: '/books').to route_to('books#create')
  end
  
  it 'routes PUT /books/:id to the books#update action' do
    expect(put: '/books/1').to route_to('books#update', id: '1')
  end
  
  it 'routes DELETE /books/:id to the books#destroy action' do
    expect(delete: '/books/1').to route_to('books#destroy', id: '1')
  end
end

RSpec.describe 'routes for Admins', type: :routing do
  it 'routes GET /admins to the admins#index action' do
    expect(get: '/admins').to route_to('admins#index')
  end
  
  it 'routes POST /admins to the admins#create action' do
    expect(post: '/admins').to route_to('admins#create')
  end
  
  it 'routes PUT /admins/:id to the admins#update action' do
    expect(put: '/admins/1').to route_to('admins#update', id: '1')
  end
  
  it 'routes DELETE /admins/:id to the admins#destroy action' do
    expect(delete: '/admins/1').to route_to('admins#destroy', id: '1')
  end
end

RSpec.describe 'routes for Sessions', type: :routing do
  
  it 'routes POST /login to the sessions#create action' do
    expect(post: '/login').to route_to('sessions#create')
  end
  
end
