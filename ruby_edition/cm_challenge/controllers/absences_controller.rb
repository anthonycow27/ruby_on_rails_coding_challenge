# frozen_string_literal: true

require 'date'

require_relative '../api'
require_relative '../services/absence_list'

# Controller handling the CRUD actions for the absences
class AbsencesController
  def initialize(params)
    @params = params
    @absences = _get_list_of_absences
  end

  def index_by_user_id
    result = []
    @absences.each do |absence|
      result.push(absence) if absence[:user_id] == @params['userId'].to_i
    end
    result
  end

  def index_by_date_range
    result = []
    @absences.each do |absence|
      result.push(absence) if _check_start_date(absence) && _check_end_date(absence)
    end
    result
  end

  private

  def _get_list_of_absences
    AbsenceList.create
  end

  def _check_start_date(absence)
    Date.parse(absence[:start_date]) >= Date.parse(@params[:startDate])
  end

  def _check_end_date(absence)
    Date.parse(absence[:end_date]) <= Date.parse(@params[:endDate])
  end
end
