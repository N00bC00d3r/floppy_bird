class Neural_Network{
  int input_layer_no,hidden_layer_no,output_layer_no;
  Matrix weight_ih,weight_ho,bias_ih,bias_ho;
  double learning_rate=0.1;
//----------------------------------------------------------------------------------------
  Neural_Network(int inputs,int hidden,int output){
    this.input_layer_no=inputs;
    this.hidden_layer_no=hidden;
    this.output_layer_no=output;
    weight_ih=new Matrix(hidden,inputs);
    weight_ho=new Matrix(output,hidden);
    this.weight_ih.randomize();
    this.weight_ho.randomize();
    bias_ih=new Matrix(hidden,1);
    bias_ho=new Matrix(output,1);
    this.bias_ih.randomize();
    this.bias_ho.randomize();
  }
 //--------------------------------------------------------------------------
  
  public double[] feedforward(double[] inputs){
    Matrix input_mat=Matrix.fromArray(inputs);
    Matrix hidden_output=Matrix.Multiply(weight_ih,input_mat);
    Matrix hidden_output_bias=Matrix.Add(hidden_output,bias_ih);
    
    //Apply Activation function to it
    
    Matrix hidden_activation=Matrix.ApplySigmoid(hidden_output_bias);
    
    //output layer calculation
    
    Matrix output=Matrix.Multiply(weight_ho,hidden_activation);
    Matrix output_bias=Matrix.Add(output,bias_ho);
    
    Matrix finalguess=Matrix.ApplySigmoid(output_bias);
    
    double[] guess=Matrix.toArray(finalguess);
    return guess;
    
  }
//--------------------------------------------------------------------- 
  public void mutate(double rate){
    double r=Math.random();
    if(r<rate){
      weight_ih=Gaussian(weight_ih);
      weight_ho=Gaussian(weight_ho);
      bias_ih=Gaussian(bias_ih);
      bias_ho=Gaussian(bias_ho);
    }
    
  }
//-------------------------------------------------------------------------------------------------
  public Matrix Gaussian(Matrix a){
    Matrix c=new Matrix(a.rows,a.cols);
    for(int i=0;i<a.rows;i++){
        for(int j=0;j<a.cols;j++){
          c.data[i][j]=a.data[i][j]+randomGaussian();
          
        }
    }
    return c;
    
  }
//-------------------------------------------------------------------------------------------------
void printNN(){
  weight_ih.printMatrix();
  weight_ho.printMatrix();
  bias_ih.printMatrix();
  bias_ho.printMatrix();
  
}
}
