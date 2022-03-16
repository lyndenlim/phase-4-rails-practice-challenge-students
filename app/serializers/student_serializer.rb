class StudentSerializer < ActiveModel::Serializer
  attributes :id, :name, :major, :age, :instructor_name

  def instructor_name
    self.object.instructor.name
  end
end
