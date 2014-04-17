require "spec_helper"

describe ProductsController do
  describe "GET #index" do
    it "requires authentication" do
      get :index, locale: :es
      expect(response).to_not be_success
      expect(response.status).to eq(302)
    end

    context "as an authenticated user" do
      before(:each) do 
        login_user(create_user)
      end

      it "responds successfully with an HTTP 200 status code" do
        get :index, locale: :es
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        get :index, locale: :es
        expect(response).to render_template("index")
      end

      it "loads all of the products into @products" do
        carrot = create_product
        potato = create_product(name: "potato")

        get :index, locale: :es

        expect(assigns(:products)).to match_array([carrot, potato])
      end
    end
  end
end
