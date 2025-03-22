import os
from diagrams import Diagram
from diagrams.aws.compute import EC2
from diagrams.aws.database import RDS
from diagrams.aws.network import ELB

curdir=os.path.dirname(os.path.abspath(__file__))

with Diagram("Web Service", show=False, filename=os.path.join(curdir, "web_service_diagram"), outformat=["jpg", "png", "pdf"]):
    ELB("lb") >> EC2("web") >> RDS("userdb")
