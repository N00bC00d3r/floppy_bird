class Neural_Network{
  int input_layer_no,hidden_layer_no,output_layer_no;
  Matrix weight_ih,weight_ho,bias_ih,bias_ho;
  double learning_rate=0.01;
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
//----------------------------------------------------------------------------------
  public void train(double[] inputs,double[] target){
    Matrix input_mat=Matrix.fromArray(inputs);
    //println("input:");
    //input_mat.printMatrix();
    //println("weight:");
    //weight_ho.printMatrix();
    //println("bias:");
    //bias_ho.printMatrix();
    //calculating hidden layer output
    Matrix hidden_output=Matrix.Multiply(weight_ih,input_mat);
    Matrix hidden_output_bias=Matrix.Add(hidden_output,bias_ih);
    Matrix hidden_layer_output=Matrix.ApplySigmoid(hidden_output_bias);
    //  println("hidden layer output");
    //hidden_layer_output.printMatrix();
    
    //calculating final output
    Matrix output=Matrix.Multiply(weight_ho,hidden_layer_output);
    Matrix output_bias=Matrix.Add(output,bias_ho);
    Matrix final_output=Matrix.ApplySigmoid(output_bias);
      //println("final output:");
      //final_output.printMatrix();
    
    Matrix answer=Matrix.fromArray(target);
    //  println("answer output");
    //answer.printMatrix();
    
    //calculating deltas in weights of hidden layer to output layer
    Matrix output_error=Matrix.Subtract(answer,final_output);
     // println("output error");
     //output_error.printMatrix();
    
    Matrix output_der=Matrix.dfSigmoid(final_output);
    //  println("output der");
    //output_der.printMatrix();
    Matrix hadamard_res_output=Matrix.HadamardMultiply(output_error,output_der);
    //  println("hadamard:");
    //hadamard_res_output.printMatrix();
    Matrix lr_output=Matrix.multiplyScalar(hadamard_res_output,learning_rate);
    //  println("lr");
    //lr_output.printMatrix();
    Matrix hidden_t=Matrix.transpose(hidden_layer_output);
    //  println("hidden_t:");
    //hidden_t.printMatrix();
    Matrix weight_ho_deltas=Matrix.Multiply(lr_output,hidden_t);
    //  println("delta weights");
    //weight_ho_deltas.printMatrix();
    //adjusting h-o layer weights
    weight_ho=Matrix.Add(weight_ho,weight_ho_deltas);
    //  println("changed weight:");
    //weight_ho.printMatrix();
    bias_ho=Matrix.Add(bias_ho,lr_output);
    //  println("changed bias:");
    //bias_ho.printMatrix();
    //calculating deltas in weights of input to hidden layer
    
    Matrix weight_ho_t=Matrix.transpose(weight_ho);
    Matrix hidden_layer_errors=Matrix.Multiply(weight_ho_t,output_error);
    Matrix hidden_der=Matrix.dfSigmoid(hidden_layer_output);
    Matrix hadamard_hidden=Matrix.HadamardMultiply(hidden_layer_errors,hidden_der);
    Matrix lr_hidden=Matrix.multiplyScalar(hadamard_hidden,learning_rate);
    Matrix input_t=Matrix.transpose(input_mat);
    Matrix weight_ih_deltas=Matrix.Multiply(lr_hidden,input_t);
    
    //adjusting i-h layer weights
    weight_ih=Matrix.Add(weight_ih,weight_ih_deltas);
    bias_ih=Matrix.Add(bias_ih,lr_hidden);
    
  }
//-------------------------------------------------------------------------------------------- 
  public void mutate(float rate){
    float r=random(1);
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
          c.data[i][j]=a.data[i][j]+random(-0.4,0.4);
        }
    }
    return c;
    
  }
//-------------------------------------------------------------------------------------------------
}
