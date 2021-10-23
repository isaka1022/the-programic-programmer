class Accound < PersistanceBaseClass
end

# 不要なAPIはAccountクラスのクライアントから全く見えなくなった
# 自らが必要とするAPIも自由に作れるようになった
class Account
  def initialize(...)
    @repo = Persiter.for(self)
  end

  def save
    @repo.save
  end
end
