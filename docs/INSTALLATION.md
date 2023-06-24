## Prerequisites

Before starting the installation, make sure you have the following:

- [Python](https://www.python.org/downloads/) installed on your system.
- [pip](https://pip.pypa.io/en/stable/installing/) package manager.

## Step 1: Update pip

Open a terminal or command prompt and run the following command to upgrade pip to the latest version:

```shell
pip install --upgrade pip
```

## Step 2: Create a Virtual Environment

A virtual environment helps isolate project dependencies. Follow these steps to create and activate a virtual environment:

Create a new virtual environment using the following command:

```shell
python -m venv venv
```

This command creates a virtual environment named "venv" in the current directory.

Activate the virtual environment:

For Windows:

```shell
venv\Scripts\activate
```

For macOS/Linux:

```shell
source venv/bin/activate
```

Once activated, you will see "(venv)" at the beginning of your command prompt, indicating that you are now working within the virtual environment.

## Step 3: Install Streamlit

With the virtual environment activated, run the following command to install Streamlit:

```shell
pip install streamlit
```

Streamlit and its dependencies will be installed into your virtual environment.

### Usage

After the installation is complete, navigate to your project directory using the terminal or command prompt.

Launch the Streamlit application with the following command:

```shell
streamlit run ./src/app.py
```
## For contract deployment using python

```shell
pip install flow_py_sdk
```
In order to run the deployment contract use 
```shell
python3 src/deployment/contract_deployment.py
```
