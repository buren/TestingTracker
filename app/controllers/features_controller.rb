class FeaturesController < ApplicationController
  before_action :require_user
  before_action :set_test_suite
  before_action :set_feature, only: [:show, :edit, :update, :destroy, :approve]

  # GET /features/1
  def show
    @issues = @feature.issues
  end

  # GET /features/new
  def new
    @feature = Feature.new
  end

  # GET /features/1/edit
  def edit
  end

  # POST /features
  def create
    @feature = Feature.new(feature_params)
    @feature.test_suite = @test_suite
    if @feature.save
      redirect_to test_suite_feature_path(@test_suite, @feature), notice: 'Feature was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /features/1
  def update
    if @feature.update(feature_params)
      redirect_to test_suite_feature_path(@test_suite, @feature), notice: 'Feature was successfully updated.'
    else
      render :edit
    end
  end

  def approve
    tester = Tester.find_by(user_id: current_user.id, test_suite_id: @test_suite.id)
    @approval = Approval.new(tester: tester, feature: @feature)
    if @approval.save
      redirect_to test_suite_feature_path(@test_suite, @feature), notice: 'Feature approved.'
    else
      redirect_to test_suite_feature_path(@test_suite, @feature), danger: 'Failed to save approval'
    end
  end

  # DELETE /features/1
  def destroy
    @feature.destroy
    redirect_to test_suite_url(@test_suite), notice: 'Feature was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feature
      @feature = @test_suite.features.find(params[:id])
    end

    def set_test_suite
      @test_suite = TestSuite.find(params[:test_suite_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feature_params
      params.require(:feature).permit(:name, :description_markdown)
    end
end
