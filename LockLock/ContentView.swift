//
//  ContentView.swift
//  LockLock
//
//  Created by Devin Maleke on 20/03/23.
//

import SwiftUI


struct ContentView: View {
    @State private var userName: String = "Figo"
    @State private var userLocker: Set<String> = []
    @State private var isLoading = false
    @EnvironmentObject var dbQuery: DBQuery
    
        
//        init(){
//            userLocker = initLocker()
//        }
    var body: some View {
        NavigationView{
            if isLoading{
                ZStack{
                    Color(.systemBackground).ignoresSafeArea()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(4)
                }
                
            }
            else{
                VStack (alignment: .leading){
                    
                    NavigationLink(destination: AfterChooseLockerView(isOk: $isLoading).environmentObject(dbQuery).navigationBarBackButtonHidden(true)){
                        Label("Clock-in With Face ID", systemImage: "clock")
                            .font(Font.headline.weight(.bold))
                            .frame(width: 350, height: 40)
                            .foregroundColor(.white)
                            .background(Color(red: -0.002, green: 0.502, blue: 0.662))
                            .cornerRadius(10)
                            .padding(.top,30)
                    }.onAppear{
                        dbQuery.getCurLocker()
                    }
                    
                    
                    HStack{
                        Text("January").padding([.top,.trailing],20)
                            .padding([.bottom],10)
                        Text("February").padding([.top,.trailing],20)
                            .padding([.bottom],10)
                        Text("March")
                            .padding([.top,.trailing],20)
                            .padding([.bottom],10)
                            .underline()
                    }
                    
                    List{VStack(alignment: .leading){
                        Text(" 2023-03-16").font(Font.headline.weight(.bold))
                            .foregroundColor(.black)
                        Divider()
                        HStack{
                            Label("Clock-in", systemImage: "clock.badge.checkmark")
                                .foregroundColor(Color(red: 0.118, green: 0.118, blue: 0.118))
                            Spacer()
                            Text("13.22").font(Font.headline.weight(.bold))
                                .foregroundColor(Color(red: 0.118, green: 0.118, blue: 0.118))
                        }
                        Divider()
                        HStack{
                            Label("Clock-out", systemImage: "arrow.up.circle.badge.clock")
                                .foregroundColor(Color(red: 0.118, green: 0.118, blue: 0.118))
                            Spacer()
                            Text("13.22").font(Font.headline.weight(.bold))
                                .foregroundColor(Color(red: 0.118, green: 0.118, blue: 0.118))
                        }
                        
                        
                        
                    }}
                    
                    
                    
                    
                    
                    
                    
                    
                    Spacer()
                    
                }
                .padding()
                .padding(.top, 80)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        ZStack{
                            Image("BackgroundJudul")
                                .resizable()
                                .frame(width: 390, height:162)
                                
                            VStack{
                                
                            
                                HStack{
                                    
                                    Text("Hi, Diana 👋")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Spacer()
                                    
                                }.padding(.leading,20)
                            }.padding(.top,140)
                        }
                    }
                                }
                                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onAppear{
            loadingCall()
        }
    }
    
    func loadingCall(){
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
            isLoading = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DBQuery())
    }
}
