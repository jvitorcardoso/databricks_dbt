def get_dbutils():
        try:
            import IPython
            return IPython.get_ipython().user_ns["dbutils"]
        except:
            raise Exception("dbutils not available: este código deve rodar dentro de um notebook Databricks")

class BaseIngestion:
    def __init__(self, layer: str):
        self.layer = layer.lower()
        self.env = "dev"
        
        # Coleta o contexto do notebook dinamicamente
        self.notebook_path = get_dbutils().notebook.entry_point.getDbutils().notebook().getContext().notebookPath().get()
        parts = self.notebook_path.split("/")
        self.domain = parts[-6]
        self.project = parts[-5]
        self.subject = parts[-2]

        self.base_path = f"/Volumes/one_lake_{self.env}/{self.layer}/landzone/{self.project}/fct/{self.subject}"
        self.schema_location = f"{self.base_path}/checkpoint"
        self.output_path = f"{self.base_path}/data"

    def get_resource_tags(self):
        return f"domain={self.domain},project={self.project},subject={self.subject},layer={self.layer},env={self.env}"

    def get_metadata(self):
        return {
            "env": self.env,
            "domain": self.domain,
            "project": self.project,
            "subject": self.subject,
            "layer": self.layer
        }
