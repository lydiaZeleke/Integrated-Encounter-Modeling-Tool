from setuptools import setup, find_packages

setup(
    name='IntegratedEncounterTool',  # Replace with your project's name
    version='1.0',  # Replace with your project's version
    packages=find_packages(),
    description='An Integrated Encounter Modeling and Simulation Tool',  # Add a short description
    author='Lydia Zeleke',  # Replace with your name
    author_email='lzeleke@aggies.ncat.edu',  # Replace with your email
    url='https://github.com/yourusername/yourproject',  # Replace with your project's URL
    install_requires=[
        'wheel',
        'numpy==1.26.3',
        'pandas>=0.25.3',
        'matplotlib==3.1.2',
        'scikit-learn',
        'pathos',  # Add your project dependencies here
        'plotly',
        'ruptures',
        'scipy==1.5.0',
        'torch',
        'tensorflow-addons'
 
    ],
    python_requires='>=3.7',  # Specify the Python version requirements
    # Additional metadata
    classifiers=[
        'Programming Language :: Python :: 3',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent',
    ],
)
