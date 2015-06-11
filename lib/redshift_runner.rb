require "redshift_runner/version"
require "redshift_runner/connection"
require "redshift_runner/result"
require "pg"

module RedshiftRunner

  def self.exec_query(query_str, connection_name='default')    
    start_time = DateTime.now    
    begin
      result = Connection.fetch(connection_name).conn.exec_params(query_str)
    rescue PG::Error => err
      result = err.result
    end
    RedshiftRunner::Result.new(result, query_str, start_time)
  end

end