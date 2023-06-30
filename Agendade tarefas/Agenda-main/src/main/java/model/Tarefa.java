package model;

public class Tarefa{
	private int id;
	private String titulo;
	private String descricao;
	private String dataInicio;
	private String dataFinal;
	private String status;
	private int userId;

	public Tarefa(String title, String description, String creationDate, String completionDate, String status, int userId) {
	        this.titulo = title;
	        this.descricao = description;
	        this.dataInicio = creationDate;
	        this.dataFinal = completionDate;
	        this.status = status;
	        this.userId = userId;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getTitle() {
		return titulo;
	}

	public void setTitle(String title) {
		this.titulo = title;
	}



	public String getDescription() {
		return descricao;
	}



	public void setDescription(String description) {
		this.descricao = description;
	}



	public String getCreationDate() {
		return dataInicio;
	}



	public void setCreationDate(String creationDate) {
		this.dataInicio = creationDate;
	}



	public String getCompletionDate() {
		return dataFinal;
	}



	public void setCompletionDate(String completionDate) {
		this.dataFinal = completionDate;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}



	public int getUserId() {
		return userId;
	}



	public void setUserId(int userId) {
		this.userId = userId;
	}

}