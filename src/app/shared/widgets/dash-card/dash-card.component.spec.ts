import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DashCardComponent } from './dash-card.component';

describe('DashCardComponent', () => {
  let component: DashCardComponent;
  let fixture: ComponentFixture<DashCardComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DashCardComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(DashCardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
